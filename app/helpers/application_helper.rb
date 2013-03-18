module ApplicationHelper
  def user_likes_page?
    fb_request = parse_signed_request
    return fb_request['page']['liked'] if fb_request && fb_request['page']
  end

  def user_is_admin?
    fb_request = parse_signed_request
    puts fb_request['page']['admin'] if fb_request && fb_request['page']
    return fb_request['page']['admin'] if fb_request && fb_request['page']
  end

  # based on http://www.chilipepperdesign.com/2011/02/15/reveal-fan-gate-like-gate-facebook-iframe-tab-tutorial-with-php
  def parse_signed_request
    if params[:signed_request].present?
      sig, payload = params[:signed_request].split('.')
      # add back the padding stripped off by FB base64url encoding
      payload += '=' * (4 - payload.length.modulo(4))
      # translate base64url chars to base64 characters
      payload = payload.tr('-_','+/')
      # retrieve the payload JSON string
      data = Base64.decode64( payload )
      # quick and dirty, so skip signature verification and just return the data as a hash
      JSON.parse( data )
    end
  rescue Exception => e
    Rails.logger.warn "!!! Error parsing signed_request"
    Rails.logger.warn e.message
  end

end
