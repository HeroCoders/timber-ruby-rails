require "timber-rails/active_record/log_subscriber/timber_log_subscriber"

module Timber
  module Integrations
    module ActiveRecord
      # Reponsible for uninstalling the default `ActiveRecord::LogSubscriber` and replacing it
      # with the `TimberLogSubscriber`.
      #
      # @private
      class LogSubscriber < Integrator
        def integrate!
          return true if Util::ActiveSupportLogSubscriber.subscribed?(:active_record, TimberLogSubscriber)

          Util::ActiveSupportLogSubscriber.unsubscribe!(:active_record, ::ActiveRecord::LogSubscriber)
          TimberLogSubscriber.attach_to(:active_record)
        end
      end
    end
  end
end
