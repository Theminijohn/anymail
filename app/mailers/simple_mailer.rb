class SimpleMailer < MandrillMailer::TemplateMailer
  default from: "from@example.com"

  def invite(email)

    mandrill_mail template: 'test-template-001',
                  subject: 'Test From Test',
                  to: { email: email, name: 'The Mini John' },
                  vars: {
                    'TEST_ONE' => 'First Variable Test',
                    'TEST_TWO' => 'Second Variable Test'
                  },
                  important: true,
                  inline_css: true
  end

end
