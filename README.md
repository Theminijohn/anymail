## Mandrill & Mailchimp Templating

### Getting Ready

[mandrill_mailer](https://github.com/renz45/mandrill_mailer)

`config/initializers/mail.rb`:

```ruby
ActionMailer::Base.smtp_settings = {
    :address   => "smtp.mandrillapp.com",
    :port      => 587,
    :user_name => ENV['MANDRILL_USERNAME'],
    :password  => ENV['MANDRILL_PASSWORD'],
    :domain    => 'heroku.com'
  }
ActionMailer::Base.delivery_method = :smtp

MandrillMailer.configure do |config|
  config.api_key = ENV['MANDRILL_API_KEY']
end
```

You don't need to add the ActionMailer stuff unless you're still using ActionMailer emails.

This uses the Mandrill SMTP servers. If you're using template-based emails through the Mandrill API you only need the MandrillMailer.configure portion.

Do not forget to setup the environment (ENV) variables on your server instead of hardcoding your Mandrill username and password in the mail.rb initializer.

You will also need to set default_url_options for the mailer, similar to ActionMailer in your environment config files in config/environments:

`config.mandrill_mailer.default_url_options = { :host => 'localhost' }`

### Creating a new mailer

Creating a new Mandrill mailer is similar to a typical Rails one:

```ruby
class InvitationMailer < MandrillMailer::TemplateMailer
  default from: 'support@example.com'

  def invite(invitation)
    # in this example `invitation.invitees` is an Array
    invitees = invitation.invitees.map { |invitee| { email: invitee.email, name: invitee.name } }

    mandrill_mail template: 'group-invite',
                  subject: I18n.t('invitation_mailer.invite.subject'),
                  to: invitees,
                  # to: invitation.email,
                  # to: { email: invitation.email, name: 'Honored Guest' },
                  vars: {
                    'OWNER_NAME' => invitation.owner_name,
                    'PROJECT_NAME' => invitation.project_name
                  },
                  important: true,
                  inline_css: true,
                  recipient_vars: invitation.invitees.map do |invitee| # invitation.invitees is an Array
                    { invitee.email =>
                      {
                        'INVITEE_NAME' => invitee.name,
                        'INVITATION_URL' => new_invitation_url(invitee.email, secret: invitee.secret_code)
                      }
                    }
                  end
  end
end
```

* `#default:`
  * `:from` - set the default from email address for the mailer
  * `:from_name` - set the default from name for the mailer. If not set, defaults to from email address. Setting :from_name in the .mandrill_mail overrides the default.

* `.mandrill_mail`
   * `:template`(required) - Template slug from within Mandrill (for backwards-compatibility, the template name may also be used but the immutable slug is preferred)

   * `:subject` - Subject of the email. If no subject supplied, it will fall back to the template default subject from within Mandrill

   * `:to`(required) - Accepts an email String, a Hash with :name and :email keys, or an Array of Hashes with :name and :email keys
      - examples:
        1. `'example@domain.com'`
        2. `{ email: 'someone@email.com', name: 'Bob Bertly' }`
        3. `[{ email: 'someone@email.com', name: 'Bob Bertly' }, { email: 'other@email.com', name: 'Claire Nayo' }]`

   * `:vars` - A Hash of merge tags made available to the email. Use them in the
     email by wrapping them in `*||*`. For example `{'OWNER_NAME' => 'Suzy'}` is used by doing: `*|OWNER_NAME|*` in the email template within Mandrill

   * `:recipient_vars` - Similar to `:vars`, this is a Hash of merge vars specific to a particular recipient.
     Use this if you are sending batch transactions and hence need to send multiple emails at one go.
     ex. `[{'someone@email.com' => {'INVITEE_NAME' => 'Roger'}}, {'another@email.com' => {'INVITEE_NAME' => 'Tommy'}}]`

   * `:template_content` - A Hash of values and content for Mandrill editable content blocks.
     In MailChimp templates there are editable regions with 'mc:edit' attributes that look
     like: `<div mc:edit="header">My email content</div>` You can insert content directly into
     these fields by passing a Hash `{'header' => 'my email content'}`

   * `:headers` - Extra headers to add to the message (currently only `Reply-To` and `X-*` headers are allowed) {"...": "..."}

   * `:bcc` - Add an email to bcc to

   * `:tags` - Array of Strings to tag the message with. Stats are
   accumulated using tags, though we only store the first 100 we see,
   so this should not be unique or change frequently. Tags should be
   50 characters or less. Any tags starting with an underscore are
   reserved for internal use and will cause errors.

   * `:google_analytics_domains` - Array of Strings indicating for which any
   matching URLs will automatically have Google Analytics parameters appended
   to their query string automatically.

   * `:google_analytics_campaign` - String indicating the value to set for
   the utm_campaign tracking parameter. If this isn't provided the email's
   from address will be used instead.

   * `:important` - whether or not this message is important, and should be delivered ahead of non-important messages.

   * `:inline_css` - whether or not to automatically inline all CSS styles provided in the message HTML - only for HTML documents less than 256KB in size.

   * `:attachments` - An array of file objects with the following keys:
      * `file:` This is the actual file, it will be converted to byte data in the mailer
      * `filename:` The name of the file
      * `mimetype:` This is the mimetype of the file. Ex. png = image/png, pdf = application/pdf, txt = text/plain etc

   * `:images` - An array of embedded images to add to the message:
      * `file:` This is the actual file, it will be converted to byte data in the mailer
      * `filename:` The Content ID of the image - use `<img src="cid:THIS_VALUE">` to reference the image in your HTML content
      * `mimetype:` The MIME type of the image - must start with "image/"

   * `:async` - Whether or not this message should be sent asynchronously

   * `:ip_pool` - The name of the dedicated ip pool that should be used to send the message

   * `:send_at` - When this message should be sent