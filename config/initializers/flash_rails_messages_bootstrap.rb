# frozen_string_literal: true

module FlashRailsMessages
  class Base
    def close_element
      tag.button type: 'button', class: 'btn-close', 'data-bs-dismiss': 'alert', 'aria-label': 'Close'
    end

    def alert_type_classes
      {
        success: 'alert-success',
        notice: 'alert-success',
        alert: 'alert-danger',
        error: 'alert-danger'
      }
    end

    def custom_alert_classes
      'alert-dismissible' if options.fetch(:dismissible, false)
    end
  end
end
