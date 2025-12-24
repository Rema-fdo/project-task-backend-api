puts "Seeding Departments..."

departments = [
  "Engineering",
  "Human Resources",
  "Finance",
  "Marketing",
  "Operations"
]

departments.each do |name|
  Department.find_or_create_by!(name: name)
end

puts "Seeding Statuses..."

statuses = [
  "Open",
  "In Progress",
  "Blocked",
  "Completed",
  "Cancelled"
]

statuses.each do |name|
  Status.find_or_create_by!(name: name)
end

puts "Seeding Priorities..."

priorities = [
  "Low",
  "Medium",
  "High",
  "Critical"
]

priorities.each do |name|
  Priority.find_or_create_by!(name: name)
end

puts "Seeding Users..."

departments = Department.all

departments.each do |department|
  10.times do |i|
    email = "#{department.name.downcase.gsub(' ', '_')}_user#{i + 1}@example.com"

    User.find_or_create_by!(email: email) do |user|
      user.name = "#{department.name} User #{i + 1}"
      user.password = "Password@123"
      user.role = "employee"
      user.department = department

      # mobile optional
      user.mobile = i.even? ? "9#{rand(100000000..999999999)}" : nil
    end
  end
end

# Admin user (kept separate)
engineering = Department.find_by!(name: "Engineering")

User.find_or_create_by!(email: "admin@example.com") do |user|
  user.name = "Admin User"
  user.password = "Admin@123"
  user.role = "admin"
  user.department = engineering
end
