# frozen_string_literal: true

module ServiceHelper
  attr_reader :error, :message, :code, :additional_data

  private

  def false_with_error(error, code = nil, additional_data = nil)
    @error = error
    @code = code
    @additional_data = additional_data
    false
  end

  def true_with_message(message, additional_data = nil)
    @message = message
    @additional_data = additional_data
    true
  end
end
