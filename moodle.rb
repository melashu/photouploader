  def testmoodle
    if @registration_payment.payment_transaction.finance_approval_status == "approved"
      @moodle = MoodleRb.new("c9687c85baec73e85ad30c281c25e229", "https://lms.leadstar.edu.et/webservice/rest/server.php")
      if !(@moodle.users.search(email: "#{@registration_payment.student.email}").present?)
        student = @moodle.users.create(
          { :username => "#{@registration_payment.student.student_id.downcase}",
            :password => "#{@registration_payment.student.student_password}",
            :firstname => "#{@registration_payment.student.first_name}",
            :lastname => "#{@registration_payment.student.last_name}",
            :email => "#{@registration_payment.student.email}" }
        )
  
        @user = student["id"]
        @registration_payment.semester_registration.course_registrations.each do |c|
          s = @moodle.courses.search("#{c.course.course_code}")
          @course = s["courses"].to_a[0]["id"]
          @moodle.enrolments.create(
            :user_id => "#{@user}",
            :course_id => "#{@course}",
          )
        end
      end
    end
  end
