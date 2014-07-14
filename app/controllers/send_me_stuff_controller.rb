class SendMeStuffController < ApplicationController

  def home
  end

  def simple_send

    # # https://mandrillapp.com/api/docs/messages.ruby.html#method=send-template
    # begin

    #   mandrill = Mandrill::API.new 'gspoGuW-dBAJwPj-Jqdpdw'
    #   template_name = "test-template-001"

    #   # Template Variables
    #   # the injection of a single piece of content into a single editable region
    #   template_content = [{
    #     "content"=>"This is a Test",
    #     "name"=>"The Mini John"
    #     }]

    #   # the other information on the message to send - same as /messages/send, but without the html content
    #   message = {
    #     "subject" => "Testing things out",
    #     "from_name" => "The Other Mini John",
    #     "from_email" => "TheOther@minijohn.me",

    #     # an array of recipient information.
    #     "to" => [{
    #       "email"=>"the@minijohn.me",
    #       "name"=>"Recipient Name", # the optional display name to use for the recipient
    #       "type"=>"to" # the header type to use for the recipient, defaults to "to" if not provided, oneof(to, cc, bcc)
    #       }],

    #     # whether or not this message is important, and should be delivered ahead of non-important messages
    #     "important" => true,

    #     # whether or not to turn on open tracking for the message
    #     "track_opens" => true,

    #     # whether or not to turn on click tracking for the message
    #     "track_clicks" => true
    #   }

    #   # enable a background sending mode that is optimized for bulk sending. In
    #   # async mode, messages/send will immediately return a status of "queued" for
    #   # every recipient. To handle rejections when sending in async mode, set up a
    #   # webhook for the 'reject' event. Defaults to false for messages with no more
    #   # than 10 recipients; messages with more than 10 recipients are always sent
    #   # asynchronously, regardless of the value of async.
    #   async = false

    # rescue Mandrill::Error => e
    #   # Mandrill errors are thrown as exceptions
    #   puts "A mandrill error occurred: #{e.class} - #{e.message}"
    #   # A mandrill error occurred: Mandrill::UnknownSubaccountError - No subaccount exists with the id 'customer-123'
    #   raise


    # end

  end

end
