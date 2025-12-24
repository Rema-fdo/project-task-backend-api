class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :email, :mobile, :role, :department_id, :created_at
end
