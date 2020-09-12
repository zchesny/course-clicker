# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y; e.g. Course has_many Attendances) 
- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Attendance belongs_to Course)
- [x] Include at least two has_many through relationships (x has_many y through z; e.g. User has_many Courses through UserCourses, User has_many Attendances through UserAttendances)
- [x] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. User has_many Courses through UserCourses, Course has_many Users through UserCourses)
- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity)
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Course, Attendance)
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_courses URL: /users/most_courses); Attendance filtering (finding by course_id and or user_id)
- [x] Include signup
- [x] Include login
- [x] Include logout
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
- [x] Include nested resource show or index (URL e.g. courses/2/attendances)
- [x] Include nested resource "new" form (URL e.g. courses/1/attendances/new)
- [x] Include form display of validation errors (form URL e.g. /users/new)

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate