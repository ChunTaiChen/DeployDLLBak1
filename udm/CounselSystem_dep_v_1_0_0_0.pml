<Project Name="CounselSystem_dep">
	<Property Name="UDT">
		<Release Version="1.0.0.0" URL="udm/UDT_1_0_0_0.tcmd"></Release>
	</Property>
	<Property Name="UDS">
		<Contract Name="ischool.counsel.student" Enabled="True">
	<Definition>
      <Authentication Extends="sa" />
    </Definition>
	<Package Name="ab_card">
		<Service Enabled="true" Name="AddABCardData">
			<Definition Type="DBHelper">
          <Action>Insert</Action>
          <SQLTemplate><![CDATA[INSERT INTO $counsel.ab_card.data @@FieldList]]></SQLTemplate>
          <RequestRecordElement>Template</RequestRecordElement>
          <FieldList Name="FieldList" Source="">
            <Field InputType="Xml" Source="Content" Target="content" />
            <Field Source="StudentID" SourceType="Variable" Target="ref_student_id" />
            <Field Source="SubjectName" Target="subject_name" />
            <Field Source="TemplateID" Target="ref_template_id" />
            <Field AutoNumber="True" Quote="False" Source="Uid" Target="uid" />
          </FieldList>
          <InternalVariable>
            <Variable Key="StudentID" Name="StudentID" Source="UserInfo" />
          </InternalVariable>
        </Definition>
		</Service>
		<Service Enabled="true" Name="GetABCardData">
			<Definition Type="DBHelper">
          <Action>Select</Action>
          <SQLTemplate><![CDATA[SELECT @@FieldList
FROM $counsel.ab_card.data
WHERE @@Condition]]></SQLTemplate>
          <ResponseRecordElement>Result/Template</ResponseRecordElement>
          <FieldList Name="FieldList" Source="Field">
            <Field Alias="Uid" Mandatory="True" Source="Uid" Target="uid" />
            <Field Alias="Content" Mandatory="True" OutputType="Xml" Source="Content" Target="content" />
            <Field Alias="SubjectName" Mandatory="True" Source="SubjectName" Target="subject_name" />
            <Field Alias="TemplateID" Mandatory="True" Source="TemplateID" Target="ref_template_id" />
          </FieldList>
          <Conditions Name="Condition" Required="False" Source="Condition">
            <Condition Source="StudentID" SourceType="Variable" Target="ref_student_id" />
          </Conditions>
          <Orders Name="" Source="" />
          <Pagination Allow="True" />
          <InternalVariable>
            <Variable Key="StudentID" Name="StudentID" Source="UserInfo" />
          </InternalVariable>
        </Definition>
		</Service>
		<Service Enabled="true" Name="GetABCardDateTimeRange">
			<Definition Type="DBHelper">
				<Action>Select</Action>
				<SQLTemplate><![CDATA[SELECT @@FieldList FROM $counsel.system_list WHERE name='ABCardAccessStartingDate']]></SQLTemplate>
				<ResponseRecordElement>Result</ResponseRecordElement>
				<FieldList Name="FieldList" Source="Field">
					<Field Alias="Uid" Mandatory="True" Source="Uid" Target="uid" />
					<Field Alias="LastUpdate" Mandatory="True" Source="LastUpdate" Target="last_update" />
					<Field Alias="Content" Mandatory="True" OutputType="Xml" Source="Content" Target="content" />
					<Field Alias="Name" Mandatory="True" Source="Name" Target="name" />
				</FieldList>
				<Conditions Name="" Required="False" Source="" />
				<Orders Name="" Source="" />
				<Pagination Allow="True" />
			</Definition>
		</Service>
		<Service Enabled="true" Name="GetABCardTemplate">
			<Definition Type="DBHelper">
          <Action>Select</Action>
          <SQLTemplate><![CDATA[SELECT @@FieldList
FROM $counsel.ab_card.template
ORDER BY priority]]></SQLTemplate>
          <ResponseRecordElement>Result/Template</ResponseRecordElement>
          <FieldList Name="FieldList" Source="">
            <Field Alias="Uid" Mandatory="True" Source="Uid" Target="uid" />
            <Field Alias="Content" Mandatory="True" OutputType="Xml" Source="Content" Target="content" />
            <Field Alias="SubjectName" Mandatory="True" Source="SubjectName" Target="subject_name" />
          </FieldList>
          <Pagination Allow="True" />
        </Definition>
		</Service>
		<Service Enabled="true" Name="GetStudentGradeYear">
			<Definition Type="dbhelper">
	<Action>Select</Action>
	<SQLTemplate>
		<![CDATA[SELECT @@FieldList FROM student inner join class on student.ref_class_id=class.id WHERE @@Condition @@Order]]>
	</SQLTemplate>
	<ResponseRecordElement>Result</ResponseRecordElement>
	<FieldList Name="FieldList" Source="Field">
		<Field Alias="StudentID" Mandatory="True" Source="StudentID" Target="student.id" />
		<Field Alias="GradeYear" Mandatory="True" Source="GradeYear" Target="class.grade_year" />
	</FieldList>
	<Conditions Name="Condition" Required="False" Source="Condition">
		<Condition Source="StudentID" SourceType="Variable" Target="student.id" />
	</Conditions>
	<Orders Name="Order" Source="Order" />
	<Pagination Allow="True" />
	<InternalVariable>
		<Variable Key="StudentID" Name="StudentID" Source="UserInfo" />
	</InternalVariable>
</Definition>
		</Service>
		<Service Enabled="true" Name="UpdateABCardData">
			<Definition Type="DBHelper">
          <Action>Update</Action>
          <SQLTemplate><![CDATA[UPDATE $counsel.ab_card.data
SET @@FieldList 
WHERE @@Condition]]></SQLTemplate>
          <RequestRecordElement>Template</RequestRecordElement>
          <FieldList Name="FieldList" Source="">
            <Field InputType="Xml" Source="Content" Target="content" />
            <Field Source="SubjectName" Target="subject_name" />
          </FieldList>
          <Conditions Name="Condition" Required="False" Source="">
            <Condition Source="Uid" Target="uid" />
            <Condition Source="StudentID" SourceType="Variable" Target="ref_student_id" />
          </Conditions>
          <InternalVariable>
            <Variable Key="StudentID" Name="StudentID" Source="UserInfo" />
          </InternalVariable>
        </Definition>
		</Service>
	</Package>
	<Package Name="casemeeting_record">
		<Service Enabled="true" Name="GetCaseMeetingRecord">
			<Definition Type="DBHelper">
          <Action>Select</Action>
          <SQLTemplate><![CDATA[SELECT @@FieldList
FROM $counsel.case_meeting_record cmr
	INNER JOIN $counsel.student_list stud_list ON cmr.ref_student_id = stud_list.ref_student_id
	INNER JOIN tag_teacher ON stud_list.ref_teacher_tag_id = tag_teacher.id
	INNER JOIN teacher ON tag_teacher.ref_teacher_id = teacher.id
WHERE @@Condition
ORDER BY cmr.meeting_date DESC, cmr.meeting_time]]></SQLTemplate>
          <ResponseRecordElement>Result/Record</ResponseRecordElement>
          <FieldList Name="FieldList" Source="Field">
            <Field Alias="Attendees" Mandatory="True" OutputType="Xml" Source="Attendees" Target="attendees" />
            <Field Alias="CaseNo" Mandatory="True" Source="CaseNo" Target="case_no" />
            <Field Alias="ContentDigest" Mandatory="True" Source="ContentDigest" Target="content_digest" />
            <Field Alias="CounselType" Mandatory="True" OutputType="Xml" Source="CounselType" Target="counsel_type" />
            <Field Alias="CounselTypeKind" Mandatory="True" OutputType="Xml" Source="CounselTypeKind" Target="counsel_type_kind" />
            <Field Alias="MeetingCause" Mandatory="True" Source="MeetingCause" Target="meeting_cause" />
            <Field Alias="MeetingDate" Mandatory="True" Source="MeetingDate" Target="meeting_date" />
            <Field Alias="MeetingTime" Mandatory="True" Source="MeetingTime" Target="meeting_time" />
            <Field Alias="Place" Mandatory="True" Source="Place" Target="place" />
            <Field Alias="CounselTeacher" Mandatory="True" Source="CounselTeacher" Target="teacher.teacher_name" />
          </FieldList>
          <Conditions Name="Condition" Required="False" Source="">
            <Condition Required="True" Source="StudentID" SourceType="Variable" Target="cmr.ref_student_id" />
          </Conditions>
          <Orders Name="" Source="" />
          <Pagination Allow="True" />
          <InternalVariable>
            <Variable Key="StudentID" Name="StudentID" Source="UserInfo" />
          </InternalVariable>
        </Definition>
		</Service>
	</Package>
	<Package Name="interview_record">
		<Service Enabled="true" Name="GetInterviewRecord">
			<Definition Type="DBHelper">
          <Action>Select</Action>
          <SQLTemplate><![CDATA[SELECT @@FieldList
FROM $counsel.interview_record ir
	INNER JOIN $counsel.student_list stud_list ON ir.ref_student_id = stud_list.ref_student_id
	INNER JOIN tag_teacher tag ON stud_list.ref_teacher_tag_id = tag.id
	INNER JOIN teacher ON tag.ref_teacher_id = teacher.id
WHERE @@Condition
ORDER BY ir.interview_date DESC, ir.interview_time]]></SQLTemplate>
          <ResponseRecordElement>Result/Record</ResponseRecordElement>
          <FieldList Name="FieldList" Source="">
            <Field Alias="Attendees" Mandatory="True" OutputType="Xml" Source="Attendees" Target="attendees" />
            <Field Alias="Cause" Mandatory="True" Source="Cause" Target="cause" />
            <Field Alias="ContentDigest" Mandatory="True" Source="ContentDigest" Target="content_digest" />
            <Field Alias="CounselType" Mandatory="True" OutputType="Xml" Source="CounselType" Target="counsel_type" />
            <Field Alias="CounselTypeKind" Mandatory="True" OutputType="Xml" Source="CounselTypeKind" Target="counsel_type_kind" />
            <Field Alias="InterviewDate" Mandatory="True" Source="InterviewDate" Target="interview_date" />
            <Field Alias="InterviewTime" Mandatory="True" Source="InterviewTime" Target="interview_time" />
            <Field Alias="InterviewNo" Mandatory="True" Source="InterviewNo" Target="interview_no" />
            <Field Alias="InterviewType" Mandatory="True" Source="InterviewType" Target="interview_type" />
            <Field Alias="IntervieweeType" Mandatory="True" Source="IntervieweeType" Target="interviewee_type" />
            <Field Alias="Place" Mandatory="True" Source="Place" Target="place" />
            <Field Alias="InterviewTeacher" Mandatory="True" Source="InterviewTeacher" Target="teacher.teacher_name" />
          </FieldList>
          <Conditions Name="Condition" Required="False" Source="">
            <Condition Required="True" Source="StudentID" SourceType="Variable" Target="ir.ref_student_id" />
          </Conditions>
          <Orders Name="" Source="" />
          <Pagination Allow="True" />
          <InternalVariable>
            <Variable Key="StudentID" Name="StudentID" Source="UserInfo" />
          </InternalVariable>
        </Definition>
		</Service>
	</Package>
	<Package Name="quiz_data">
		<Service Enabled="true" Name="GetQuizData">
			<Definition Type="DBHelper">
          <Action>Select</Action>
          <SQLTemplate><![CDATA[SELECT @@FieldList
FROM $counsel.student_quiz_data qz_data
	INNER JOIN $counsel.quiz qz ON qz_data.ref_quiz_uid = qz.uid
WHERE @@Condition]]></SQLTemplate>
          <ResponseRecordElement>Result/QuizData</ResponseRecordElement>
          <FieldList Name="FieldList" Source="">
            <Field Alias="Content" Mandatory="True" OutputType="Xml" Source="Content" Target="content" />
            <Field Alias="Name" Mandatory="True" Source="QuizName" Target="quiz_name" />
          </FieldList>
          <Conditions Name="Condition" Required="False" Source="">
            <Condition Required="True" Source="StudentID" SourceType="Variable" Target="qz_data.ref_student_id" />
          </Conditions>
          <Pagination Allow="True" />
          <InternalVariable>
            <Variable Key="StudentID" Name="StudentID" Source="UserInfo" />
          </InternalVariable>
        </Definition>
		</Service>
	</Package>
</Contract>
		<Contract Name="ischool.counsel.teacher" Enabled="True">
	<Definition>
      <Authentication Extends="ta" />
    </Definition>
	<Package Name="ab_card">
		<Service Enabled="true" Name="AddABCardData">
			<Definition Type="DBHelper">
          <Action>Insert</Action>
          <SQLTemplate><![CDATA[INSERT INTO $counsel.ab_card.data @@FieldList]]></SQLTemplate>
          <RequestRecordElement>Template</RequestRecordElement>
          <FieldList Name="FieldList" Source="">
            <Field InputType="Xml" Source="Content" Target="content" />
            <Field Source="StudentID" SourceType="Variable" Target="ref_student_id" />
            <Field Source="SubjectName" Target="subject_name" />
            <Field Source="TemplateID" Target="ref_template_id" />
            <Field AutoNumber="True" Quote="False" Source="Uid" Target="uid" />
          </FieldList>
          <InternalVariable>
            <Variable Key="TeacherID" Name="TeacherID" Source="UserInfo" />
            <Variable Key="Template/StudentID" Name="StudentID" Source="Request" />
          </InternalVariable>
          <Preprocesses>
            <Preprocess InvalidMessage="很抱歉，無權修改資料" Name="VaildVisible" Type="Validate"><![CDATA[
			
select count(student.id) from student
inner join class on class.id = student.ref_class_id
where class.ref_teacher_id = '@@TeacherID' and student.id =  '@@StudentID'
		
		]]></Preprocess>
          </Preprocesses>
        </Definition>
		</Service>
		<Service Enabled="true" Name="GetABCardData">
			<Definition Type="DBHelper">
	<Action>Select</Action>
	<SQLTemplate>
		<![CDATA[SELECT @@FieldList
FROM $counsel.ab_card.data
WHERE @@Condition]]></SQLTemplate>
	<ResponseRecordElement>Result/Template</ResponseRecordElement>
	<FieldList Name="FieldList" Source="">
		<Field Alias="Uid" Mandatory="True" Source="Uid" Target="uid" />
		<Field Alias="Content" Mandatory="True" OutputType="Xml" Source="Content" Target="content" />
		<Field Alias="SubjectName" Mandatory="True" Source="SubjectName" Target="subject_name" />
		<Field Alias="TemplateID" Mandatory="True" Source="TemplateID" Target="ref_template_id" />
		<Field Alias="RefStudentID" Mandatory="True" Source="RefStudentID" Target="ref_student_id" />
	</FieldList>
	<Conditions Name="Condition" Required="False" Source="">
		<Condition Source="StudentID" Target="ref_student_id" />
	</Conditions>
	<Orders Name="" Source="" />
	<Pagination Allow="True" />
	<InternalVariable>
		<Variable Key="TeacherID" Name="TeacherID" Source="UserInfo" />
	</InternalVariable>
</Definition>
		</Service>
		<Service Enabled="true" Name="GetABCardTemplate">
			<Definition Type="DBHelper">
          <Action>Select</Action>
          <SQLTemplate><![CDATA[SELECT @@FieldList
FROM $counsel.ab_card.template
ORDER BY priority]]></SQLTemplate>
          <ResponseRecordElement>Result/Template</ResponseRecordElement>
          <FieldList Name="FieldList" Source="">
            <Field Alias="Uid" Mandatory="True" Source="Uid" Target="uid" />
            <Field Alias="Content" Mandatory="True" OutputType="Xml" Source="Content" Target="content" />
            <Field Alias="SubjectName" Mandatory="True" Source="SubjectName" Target="subject_name" />
          </FieldList>
          <Pagination Allow="True" />
        </Definition>
		</Service>
		<Service Enabled="true" Name="UpdateABCardData">
			<Definition Type="DBHelper">
          <Action>Update</Action>
          <SQLTemplate><![CDATA[UPDATE $counsel.ab_card.data
SET @@FieldList 
WHERE @@Condition]]></SQLTemplate>
          <RequestRecordElement>Template</RequestRecordElement>
          <FieldList Name="FieldList" Source="">
            <Field InputType="Xml" Source="Content" Target="content" />
            <Field Source="SubjectName" Target="subject_name" />
          </FieldList>
          <Conditions Name="Condition" Required="False" Source="">
            <Condition Source="Uid" Target="uid" />
            <Condition Source="StudentID" Target="ref_student_id" />
          </Conditions>
          <InternalVariable>
            <Variable Key="TeacherID" Name="TeacherID" Source="UserInfo" />
            <Variable Key="Template/StudentID" Name="StudentID" Source="Request" />
          </InternalVariable>
          <Preprocesses>
            <Preprocess InvalidMessage="很抱歉，無權修改資料" Name="VaildVisible" Type="Validate"><![CDATA[
			
			
select count(student.id) from student
inner join class on class.id = student.ref_class_id
where class.ref_teacher_id = '@@TeacherID' and student.id =  '@@StudentID'
		
		
		]]></Preprocess>
          </Preprocesses>
        </Definition>
		</Service>
	</Package>
	<Package Name="care_record">
		<Service Enabled="true" Name="GetCareRecord">
			<Definition Type="DBHelper">
          <Action>Select</Action>
          <SQLTemplate><![CDATA[SELECT @@FieldList
FROM $counsel.care_record cr
	INNER JOIN $counsel.student_list stud_list ON cr.ref_student_id = stud_list.ref_student_id
	INNER JOIN tag_teacher tag ON stud_list.ref_teacher_tag_id = tag.id
WHERE @@Condition
GROUP BY assisted_matter, case_category, case_category_remark, case_origin, case_origin_remark, code_name, counsel_goal, counsel_type, file_date, other_institute, superiority, weakness, cr.uid
ORDER BY cr.file_date DESC]]></SQLTemplate>
          <ResponseRecordElement>Result/Record</ResponseRecordElement>
          <FieldList Name="FieldList" Source="">
            <Field Alias="AssistedMatter" Mandatory="True" Source="AssistedMatter" Target="assisted_matter" />
            <Field Alias="CaseCategory" Mandatory="True" Source="CaseCategory" Target="case_category" />
            <Field Alias="CaseCategoryRemark" Mandatory="True" Source="CaseCategoryRemark" Target="case_category_remark" />
            <Field Alias="CaseOrigin" Mandatory="True" Source="CaseOrigin" Target="case_origin" />
            <Field Alias="CaseOriginRemark" Mandatory="True" Source="CaseOriginRemark" Target="case_origin_remark" />
            <Field Alias="CodeName" Mandatory="True" Source="CodeName" Target="code_name" />
            <Field Alias="CounselGoal" Mandatory="True" Source="CounselGoal" Target="counsel_goal" />
            <Field Alias="CounselType" Mandatory="True" Source="CounselType" Target="counsel_type" />
            <Field Alias="FileDate" Mandatory="True" Source="FileDate" Target="file_date" />
            <Field Alias="OtherInstitute" Mandatory="True" Source="OtherInstitute" Target="other_institute" />
            <Field Alias="Superiority" Mandatory="True" Source="Superiority" Target="superiority" />
            <Field Alias="Weakness" Mandatory="True" Source="Weakness" Target="weakness" />
            <Field Alias="UID" Mandatory="True" Source="UID" Target="cr.uid" />
          </FieldList>
          <Conditions Name="Condition" Required="False" Source="">
            <Condition Required="True" Source="StudentID" Target="cr.ref_student_id" />
          </Conditions>
          <Orders Name="" Source="" />
          <Pagination Allow="True" />
        </Definition>
		</Service>
	</Package>
	<Package Name="casemeeting_record">
		<Service Enabled="true" Name="AddCaseMeetingRecord">
			<Definition Type="DBHelper">
	<Action>Insert</Action>
	<SQLTemplate>
		<![CDATA[INSERT INTO $counsel.case_meeting_record @@FieldList]]></SQLTemplate>
	<RequestRecordElement>Record</RequestRecordElement>
	<FieldList Name="FieldList" Source="">
		<Field Quote="False" Source="LastUpdate" SourceType="Variable" Target="last_update" />
		<Field Source="UserName" SourceType="Variable" Target="author_id" />
		<Field Required="True" Source="StudentID" Target="ref_student_id" />
		<Field Source="TeacherID" SourceType="Variable" Target="counsel_teacher_id" />
		<Field Source="Attendees" Target="attendees" />
		<Field Source="CaseNo" Target="case_no" />
		<Field Source="ContentDigest" Target="content_digest" />
		<Field InputType="Xml" Source="CounselType" Target="counsel_type" />
		<Field InputType="Xml" Source="CounselTypeKind" Target="counsel_type_kind" />
		<Field Source="MeetingCause" Target="meeting_cause" />
		<Field Source="MeetingDate" Target="meeting_date" />
		<Field Source="MeetingTime" Target="meeting_time" />
		<Field Source="Place" Target="place" />
	</FieldList>
	<InternalVariable>
		<Variable Key="UserName" Name="UserName" Source="UserInfo" />
		<Variable Key="TeacherID" Name="TeacherID" Source="UserInfo" />
		<Variable Key="Record/StudentID" Name="StudentID" Source="Request" />
		<Variable Name="LastUpdate" Source="Literal">
			<![CDATA[
			
			
			now()
		
		
		]]></Variable>
	</InternalVariable>
	<Preprocesses>
		<Preprocess InvalidMessage="很抱歉，無權修改資料" Name="VaildVisible" Type="Validate">
			<![CDATA[
			
			
				select stud_list.uid
				from $counsel.student_list stud_list
				inner join tag_teacher on stud_list.ref_teacher_tag_id = tag_teacher.id
				inner join tag on tag_teacher.ref_tag_id = tag.id
				where tag.name = '認輔老師' and tag_teacher.ref_teacher_id = '@@TeacherID' and stud_list.ref_student_id = '@@StudentID'
		
		
		]]></Preprocess>
	</Preprocesses>
</Definition>
		</Service>
		<Service Enabled="true" Name="DeleteCaseMeetingRecord">
			<Definition Type="DBHelper">
          <Action>Delete</Action>
          <SQLTemplate><![CDATA[DELETE FROM $counsel.case_meeting_record WHERE @@Condition]]></SQLTemplate>
          <RequestRecordElement>Record</RequestRecordElement>
          <Conditions Name="Condition" Required="True" Source="">
            <Condition Required="True" Source="UID" Target="uid" />
            <Condition Required="True" Source="TeacherID" SourceType="Variable" Target="counsel_teacher_id" />
          </Conditions>
          <InternalVariable>
            <Variable Key="TeacherID" Name="TeacherID" Source="UserInfo" />
          </InternalVariable>
        </Definition>
		</Service>
		<Service Enabled="true" Name="GetCaseMeetingRecord">
			<Definition Type="DBHelper">
	<Action>Select</Action>
	<SQLTemplate>
		<![CDATA[SELECT @@FieldList
FROM $counsel.case_meeting_record cmr
	INNER JOIN $counsel.student_list stud_list ON cmr.ref_student_id = stud_list.ref_student_id
	INNER JOIN tag_teacher tag ON stud_list.ref_teacher_tag_id = tag.id
WHERE @@Condition
GROUP BY attendees, case_no, content_digest, counsel_type, counsel_type_kind, meeting_cause, meeting_date, meeting_time, place, cmr.uid, cmr.author_id, counsel_teacher_id
ORDER BY cmr.meeting_date DESC, cmr.meeting_time]]>
	</SQLTemplate>
	<ResponseRecordElement>Result/Record</ResponseRecordElement>
	<FieldList Name="FieldList" Source="">
		<Field Alias="Attendees" Mandatory="True" OutputType="Xml" Source="Attendees" Target="attendees" />
		<Field Alias="CaseNo" Mandatory="True" Source="CaseNo" Target="case_no" />
		<Field Alias="ContentDigest" Mandatory="True" Source="ContentDigest" Target="content_digest" />
		<Field Alias="CounselType" Mandatory="True" OutputType="Xml" Source="CounselType" Target="counsel_type" />
		<Field Alias="CounselTypeKind" Mandatory="True" OutputType="Xml" Source="CounselTypeKind" Target="counsel_type_kind" />
		<Field Alias="MeetingCause" Mandatory="True" Source="MeetingCause" Target="meeting_cause" />
		<Field Alias="MeetingDate" Mandatory="True" Source="MeetingDate" Target="meeting_date" />
		<Field Alias="MeetingTime" Mandatory="True" Source="MeetingTime" Target="meeting_time" />
		<Field Alias="Place" Mandatory="True" Source="Place" Target="place" />
		<Field Alias="UID" Mandatory="True" Source="UID" Target="cmr.uid" />
		<Field Alias="AuthorID" Mandatory="True" Source="AuthorID" Target="cmr.author_id" />
		<Field Alias="TeacherID" Mandatory="True" Source="TeacherID" Target="counsel_teacher_id" />
	</FieldList>
	<Conditions Name="Condition" Required="False" Source="">
		<Condition Required="True" Source="StudentID" Target="cmr.ref_student_id" />
		<Condition Required="True" Source="LoginName" SourceType="Variable" Target="cmr.author_id" />
	</Conditions>
	<Orders Name="" Source="" />
	<Pagination Allow="True" />
	<InternalVariable>
		<Variable Key="LoginName" Name="LoginName" Source="UserInfo" />
	</InternalVariable>

</Definition>
		</Service>
		<Service Enabled="true" Name="UpdateCaseMeetingRecord">
			<Definition Type="DBHelper">
          <Action>Update</Action>
          <SQLTemplate><![CDATA[UPDATE $counsel.case_meeting_record SET @@FieldList  WHERE @@Condition]]></SQLTemplate>
          <RequestRecordElement>Record</RequestRecordElement>
          <FieldList Name="FieldList" Source="">
            <Field Source="LastUpdate" SourceType="Variable" Target="last_update" />
            <Field InputType="Xml" Source="Attendees" Target="attendees" />
            <Field Source="CaseNo" Target="case_no" />
            <Field Source="ContentDigest" Target="content_digest" />
            <Field InputType="Xml" Source="CounselType" Target="counsel_type" />
            <Field InputType="Xml" Source="CounselTypeKind" Target="counsel_type_kind" />
            <Field Source="MeetingCause" Target="meeting_cause" />
            <Field Source="MeetingDate" Target="meeting_date" />
            <Field Source="MeetingTime" Target="meeting_time" />
            <Field Source="Place" Target="place" />
          </FieldList>
          <Conditions Name="Condition" Required="True" Source="">
            <Condition Required="True" Source="UID" Target="uid" />
            <Condition Required="True" Source="TeacherID" SourceType="Variable" Target="counsel_teacher_id" />
          </Conditions>
          <InternalVariable>
            <Variable Key="TeacherID" Name="TeacherID" Source="UserInfo" />
            <Variable Name="LastUpdate" Source="Literal"><![CDATA[
			now()
		]]></Variable>
          </InternalVariable>
        </Definition>
		</Service>
	</Package>
	<Package Name="global">
		<Service Enabled="true" Name="GetClasses">
			<Definition Type="DBHelper">
          <Action>Select</Action>
          <SQLTemplate><![CDATA[SELECT @@FieldList
FROM class
WHERE class.id IN (
	SELECT class.id
	FROM $counsel.student_list stud_list
		INNER JOIN tag_teacher ON tag_teacher.id = stud_list.ref_teacher_tag_id
		INNER JOIN student ON student.id = stud_list.ref_student_id
		INNER JOIN class ON class.id = student.ref_class_id
	WHERE @@Condition1 and student.status = 1
	union
	SELECT class.id
	FROM class
	WHERE @@Condition2
)
GROUP BY class.id, class.class_name
		]]></SQLTemplate>
          <ResponseRecordElement>Result/Class</ResponseRecordElement>
          <FieldList Name="FieldList" Source="">
            <Field Alias="ClassID" Mandatory="True" Source="ClassID" Target="class.id" />
            <Field Alias="ClassName" Mandatory="True" Source="ClassName" Target="class.class_name" />
          </FieldList>
          <Conditions Name="Condition1" Required="False" Source="">
            <Condition Required="True" Source="TeacherID" SourceType="Variable" Target="tag_teacher.ref_teacher_id" />
          </Conditions>
          <Conditions Name="Condition2" Required="False" Source="">
            <Condition Required="True" Source="TeacherID" SourceType="Variable" Target="class.ref_teacher_id" />
          </Conditions>
          <Orders Name="" Source="" />
          <Pagination Allow="True" />
          <InternalVariable>
            <Variable Key="TeacherID" Name="TeacherID" Source="UserInfo" />
          </InternalVariable>
        </Definition>
		</Service>
		<Service Enabled="true" Name="GetMyInfo">
			<Definition Type="DBHelper">
				<Action>Select</Action>
				<SQLTemplate><![CDATA[SELECT @@FieldList
FROM teacher
WHERE @@Condition]]></SQLTemplate>
				<ResponseRecordElement>Result</ResponseRecordElement>
				<FieldList Name="FieldList" Source="">
					<Field Alias="TeacherID" Mandatory="True" Source="TeacherID" Target="teacher.id" />
					<Field Alias="TeacherName" Mandatory="True" Source="TeacherName" Target="teacher_name" />
					<Field Alias="Nickname" Mandatory="True" Source="Nickname" Target="nickname" />
					<Field Alias="LoginName" Mandatory="True" Source="LoginName" Target="st_login_name" />
				</FieldList>
				<Conditions Name="Condition" Required="False" Source="">
					<Condition Source="TeacherID" SourceType="Variable" Target="teacher.id" />
				</Conditions>
				<Orders Name="" Source="" />
				<Pagination Allow="True" />
				<InternalVariable>
					<Variable Key="TeacherID" Name="TeacherID" Source="UserInfo" />
				</InternalVariable>
			</Definition>
		</Service>
		<Service Enabled="true" Name="GetStudentC1">
			<Definition Type="DBHelper">
	<Action>Select</Action>
	<SQLTemplate>
		<![CDATA[
SELECT *
FROM
(
	SELECT @@FieldList
	FROM $counsel.student_list stud_list
		INNER JOIN student ON student.id = stud_list.ref_student_id
		INNER JOIN tag_teacher ON tag_teacher.id = stud_list.ref_teacher_tag_id
		INNER JOIN tag ON tag_teacher.ref_tag_id = tag.id
		INNER JOIN class ON class.id = student.ref_class_id
	WHERE @@Condition1 and student.status = 1  and tag.name='認輔老師'
) as student
ORDER BY student.SeatNo]]>
	</SQLTemplate>
	<ResponseRecordElement>Result/Student</ResponseRecordElement>
	<FieldList Name="FieldList" Source="">
		<Field Alias="UID" Mandatory="True" Source="UID" Target="student.id" />
		<Field Alias="Name" Mandatory="True" Source="Name" Target="student.name" />
		<Field Alias="SeatNo" Mandatory="True" Source="SeatNo" Target="student.seat_no" />
		<Field Alias="Photo" Mandatory="True" Source="Photo" Target="student.freshman_photo" />
		<Field Alias="ClassName" Mandatory="True" Source="ClassName" Target="class.class_name" />
		<Field Alias="CounselTag" Mandatory="True" Source="CounselTag" Target="tag.name" />
		<Field Alias="StudentNumber" Mandatory="True" Source="StudentNumber" Target="student.student_number" />
	</FieldList>
	<Conditions Name="Condition1" Required="False" Source="">
		<Condition Required="True" Source="TeacherID" SourceType="Variable" Target="tag_teacher.ref_teacher_id" />
	</Conditions>
	<Pagination Allow="True" />
	<InternalVariable>
		<Variable Key="TeacherID" Name="TeacherID" Source="UserInfo" />
	</InternalVariable>
</Definition>
		</Service>
		<Service Enabled="true" Name="GetStudentC2">
			<Definition Type="DBHelper">
	<Action>Select</Action>
	<SQLTemplate>
		<![CDATA[
SELECT *
FROM
(
	SELECT @@FieldList
	FROM student
		INNER JOIN class ON class.id = student.ref_class_id
		INNER JOIN teacher ON class.ref_teacher_id = teacher.id
	WHERE @@Condition2 and student.status = 1
) as student
ORDER BY student.SeatNo]]>
	</SQLTemplate>
	<ResponseRecordElement>Result/Student</ResponseRecordElement>
	<FieldList Name="FieldList" Source="">
		<Field Alias="UID" Mandatory="True" Source="UID" Target="student.id" />
		<Field Alias="Name" Mandatory="True" Source="Name" Target="student.name" />
		<Field Alias="SeatNo" Mandatory="True" Source="SeatNo" Target="student.seat_no" />
		<Field Alias="Photo" Mandatory="True" Source="Photo" Target="student.freshman_photo" />
		<Field Alias="ClassName" Mandatory="True" Source="ClassName" Target="class.class_name" />
		<Field Alias="StudentNumber" Mandatory="True" Source="StudentNumber" Target="student.student_number" />
	</FieldList>
	<Conditions Name="Condition2" Required="False" Source="">
		<Condition Required="True" Source="TeacherID" SourceType="Variable" Target="class.ref_teacher_id" />
	</Conditions>
	<Pagination Allow="True" />
	<InternalVariable>
		<Variable Key="TeacherID" Name="TeacherID" Source="UserInfo" />
	</InternalVariable>
</Definition>
		</Service>
		<Service Enabled="true" Name="GetStudents">
			<Definition Type="DBHelper">
          <Action>Select</Action>
          <SQLTemplate><![CDATA[
SELECT *
FROM
(
	SELECT @@FieldList
	FROM $counsel.student_list stud_list
		INNER JOIN student ON student.id = stud_list.ref_student_id
		INNER JOIN tag_teacher ON tag_teacher.id = stud_list.ref_teacher_tag_id
		INNER JOIN tag ON tag_teacher.ref_tag_id = tag.id
		INNER JOIN class ON class.id = student.ref_class_id
	WHERE @@Condition1 and student.status = 1
	UNION
	SELECT student.id, student.name, student.seat_no, student.freshman_photo, class.class_name, '班導師'
	FROM student
		INNER JOIN class ON class.id = student.ref_class_id
		INNER JOIN teacher ON class.ref_teacher_id = teacher.id
	WHERE @@Condition2 and student.status = 1
) as student
ORDER BY student.SeatNo]]></SQLTemplate>
          <ResponseRecordElement>Result/Student</ResponseRecordElement>
          <FieldList Name="FieldList" Source="">
            <Field Alias="UID" Mandatory="True" Source="UID" Target="student.id" />
            <Field Alias="Name" Mandatory="True" Source="Name" Target="student.name" />
            <Field Alias="SeatNo" Mandatory="True" Source="SeatNo" Target="student.seat_no" />
            <Field Alias="Photo" Mandatory="True" Source="Photo" Target="student.freshman_photo" />
            <Field Alias="ClassName" Mandatory="True" Source="ClassName" Target="class.class_name" />
            <Field Alias="CounselTag" Mandatory="True" Source="CounselTag" Target="tag.name" />
          </FieldList>
          <Conditions Name="Condition1" Required="False" Source="">
            <Condition Required="True" Source="ClassID" Target="student.ref_class_id" />
            <Condition Required="True" Source="TeacherID" SourceType="Variable" Target="tag_teacher.ref_teacher_id" />
          </Conditions>
          <Conditions Name="Condition2" Required="False" Source="">
            <Condition Required="True" Source="ClassID" Target="student.ref_class_id" />
            <Condition Required="True" Source="TeacherID" SourceType="Variable" Target="class.ref_teacher_id" />
          </Conditions>
          <Pagination Allow="True" />
          <InternalVariable>
            <Variable Key="TeacherID" Name="TeacherID" Source="UserInfo" />
          </InternalVariable>
        </Definition>
		</Service>
	</Package>
	<Package Name="interview_record">
		<Service Enabled="true" Name="AddInterviewRecord">
			<Definition Type="DBHelper">
	<Action>Insert</Action>
	<SQLTemplate>
		<![CDATA[INSERT INTO $counsel.interview_record @@FieldList]]></SQLTemplate>
	<RequestRecordElement>Record</RequestRecordElement>
	<FieldList Name="FieldList" Source="">
		<Field Quote="False" Source="LastUpdate" SourceType="Variable" Target="last_update" />
		<Field Source="UserName" SourceType="Variable" Target="author_id" />
		<Field Required="True" Source="StudentID" Target="ref_student_id" />
		<Field Source="TeacherID" SourceType="Variable" Target="teacher_id" />
		<Field InputType="Xml" Source="Attendees" Target="attendees" />
		<Field Source="Cause" Target="cause" />
		<Field Source="ContentDigest" Target="content_digest" />
		<Field InputType="Xml" Source="CounselType" Target="counsel_type" />
		<Field InputType="Xml" Source="CounselTypeKind" Target="counsel_type_kind" />
		<Field Source="InterviewDate" Target="interview_date" />
		<Field Source="InterviewTime" Target="interview_time" />
		<Field Source="InterviewNo" Target="interview_no" />
		<Field Source="InterviewType" Target="interview_type" />
		<Field Source="IntervieweeType" Target="interviewee_type" />
		<Field Source="Place" Target="place" />
	</FieldList>
	<InternalVariable>
		<Variable Key="UserName" Name="UserName" Source="UserInfo" />
		<Variable Key="TeacherID" Name="TeacherID" Source="UserInfo" />
		<Variable Key="Record/StudentID" Name="StudentID" Source="Request" />
		<Variable Name="LastUpdate" Source="Literal">
			<![CDATA[
			
			now()
		]]></Variable>
	</InternalVariable>
	<Preprocesses>
		<Preprocess InvalidMessage="很抱歉，無權修改資料" Name="VaildVisible" Type="Validate">
			<![CDATA[
			
				select stud_list.uid
				from $counsel.student_list stud_list
				inner join tag_teacher tag on stud_list.ref_teacher_tag_id = tag.id
				where tag.ref_teacher_id = '@@TeacherID' and stud_list.ref_student_id = '@@StudentID'
				union
				select student.id
				from student
				inner join class on class.id = student.ref_class_id
				where class.ref_teacher_id = '@@TeacherID'
		]]></Preprocess>
	</Preprocesses>
</Definition>
		</Service>
		<Service Enabled="true" Name="DeleteInterviewRecord">
			<Definition Type="DBHelper">
          <Action>Delete</Action>
          <SQLTemplate><![CDATA[DELETE FROM $counsel.interview_record WHERE @@Condition]]></SQLTemplate>
          <RequestRecordElement>Record</RequestRecordElement>
          <Conditions Name="Condition" Required="True" Source="">
            <Condition Required="True" Source="UID" Target="uid" />
            <Condition Required="True" Source="TeacherID" SourceType="Variable" Target="teacher_id" />
          </Conditions>
          <InternalVariable>
            <Variable Key="TeacherID" Name="TeacherID" Source="UserInfo" />
          </InternalVariable>
        </Definition>
		</Service>
		<Service Enabled="true" Name="GetInterviewRecord">
			<Definition Type="DBHelper">
	<Action>Select</Action>
	<SQLTemplate>
		<![CDATA[SELECT @@FieldList
FROM $counsel.interview_record ir
	LEFT JOIN $counsel.student_list stud_list ON ir.ref_student_id = stud_list.ref_student_id
	LEFT JOIN tag_teacher ON stud_list.ref_teacher_tag_id = tag_teacher.id
	LEFT JOIN tag on tag_teacher.ref_tag_id = tag.id
	LEFT JOIN student ON student.id = ir.ref_student_id
	LEFT JOIN class ON class.id = student.ref_class_id
  WHERE @@Condition
--WHERE @@Condition AND (tag_teacher.ref_teacher_id=teacher_id OR class.ref_teacher_id = teacher_id)
GROUP BY attendees, cause, content_digest, counsel_type, counsel_type_kind, interview_date, interview_time, interview_no, interview_type, interviewee_type, place, ir.uid, ir.author_id, teacher_id
ORDER BY ir.interview_date DESC, ir.interview_time]]>
	</SQLTemplate>
	<ResponseRecordElement>Result/Record</ResponseRecordElement>
	<FieldList Name="FieldList" Source="">
		<Field Alias="Attendees" Mandatory="True" OutputType="Xml" Source="Attendees" Target="attendees" />
		<Field Alias="Cause" Mandatory="True" Source="Cause" Target="cause" />
		<Field Alias="ContentDigest" Mandatory="True" Source="ContentDigest" Target="content_digest" />
		<Field Alias="CounselType" Mandatory="True" OutputType="Xml" Source="CounselType" Target="counsel_type" />
		<Field Alias="CounselTypeKind" Mandatory="True" OutputType="Xml" Source="CounselTypeKind" Target="counsel_type_kind" />
		<Field Alias="InterviewDate" Mandatory="True" Source="InterviewDate" Target="interview_date" />
		<Field Alias="InterviewTime" Mandatory="True" Source="InterviewTime" Target="interview_time" />
		<Field Alias="InterviewNo" Mandatory="True" Source="InterviewNo" Target="interview_no" />
		<Field Alias="InterviewType" Mandatory="True" Source="InterviewType" Target="interview_type" />
		<Field Alias="IntervieweeType" Mandatory="True" Source="IntervieweeType" Target="interviewee_type" />
		<Field Alias="Place" Mandatory="True" Source="Place" Target="place" />
		<Field Alias="UID" Mandatory="True" Source="UID" Target="ir.uid" />
		<Field Alias="AuthorID" Mandatory="True" Source="AuthorID" Target="ir.author_id" />
		<Field Alias="TeacherID" Mandatory="True" Source="TeacherID" Target="teacher_id" />
	</FieldList>
	<Conditions Name="Condition" Required="False" Source="">
		<Condition Required="True" Source="StudentID" Target="ir.ref_student_id" />
		<Condition Required="True" Source="TeacherID" SourceType="Variable" Target="teacher_id" />
		<Condition Required="True" Source="LoginName" SourceType="Variable" Target="ir.author_id" />
	</Conditions>
	<Orders Name="" Source="" />
	<Pagination Allow="True" />
	<InternalVariable>
		<Variable Key="TeacherID" Name="TeacherID" Source="UserInfo" />
		<Variable Key="LoginName" Name="LoginName" Source="UserInfo" />
	</InternalVariable>
</Definition>
		</Service>
		<Service Enabled="true" Name="UpdateInterviewRecord">
			<Definition Type="DBHelper">
          <Action>Update</Action>
          <SQLTemplate><![CDATA[UPDATE $counsel.interview_record SET @@FieldList  WHERE @@Condition]]></SQLTemplate>
          <RequestRecordElement>Record</RequestRecordElement>
          <FieldList Name="FieldList" Source="">
            <Field Quote="False" Source="LastUpdate" SourceType="Variable" Target="last_update" />
            <Field InputType="Xml" Source="Attendees" Target="attendees" />
            <Field Source="Cause" Target="cause" />
            <Field Source="ContentDigest" Target="content_digest" />
            <Field InputType="Xml" Source="CounselType" Target="counsel_type" />
            <Field InputType="Xml" Source="CounselTypeKind" Target="counsel_type_kind" />
            <Field Source="InterviewDate" Target="interview_date" />
            <Field Source="InterviewTime" Target="interview_time" />
            <Field Source="InterviewNo" Target="interview_no" />
            <Field Source="InterviewType" Target="interview_type" />
            <Field Source="IntervieweeType" Target="interviewee_type" />
            <Field Source="IsPublic" Target="is_public" />
            <Field Source="Place" Target="place" />
          </FieldList>
          <Conditions Name="Condition" Required="True" Source="">
            <Condition Required="True" Source="UID" Target="uid" />
            <Condition Required="True" Source="TeacherID" SourceType="Variable" Target="teacher_id" />
          </Conditions>
          <InternalVariable>
            <Variable Key="TeacherID" Name="TeacherID" Source="UserInfo" />
            <Variable Name="LastUpdate" Source="Literal"><![CDATA[now()]]></Variable>
          </InternalVariable>
        </Definition>
		</Service>
	</Package>
	<Package Name="quiz_data">
		<Service Enabled="true" Name="GetStudentQuizData">
			<Definition Type="DBHelper">
	<Action>Select</Action>
	<SQLTemplate>
		<![CDATA[SELECT @@FieldList
FROM $counsel.student_quiz_data qz_data
	INNER JOIN $counsel.quiz qz ON qz_data.ref_quiz_uid = qz.uid	
WHERE @@Condition]]></SQLTemplate>
	<ResponseRecordElement>Result/QuizData</ResponseRecordElement>
	<FieldList Name="FieldList" Source="">
		<Field Alias="Content" Mandatory="True" OutputType="Xml" Source="Content" Target="content" />
		<Field Alias="Name" Mandatory="True" Source="QuizName" Target="quiz_name" />
	</FieldList>
	<Conditions Name="Condition" Required="False" Source="">
		<Condition Required="True" Source="StudentID" Target="qz_data.ref_student_id" />		
	</Conditions>	
</Definition>
		</Service>
	</Package>
</Contract>
	</Property>
</Project>