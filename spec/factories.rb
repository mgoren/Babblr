FactoryGirl.define do
  factory(:user) do
    username('foo')
    email('foo@foo.com')
    password('password')
  end

  factory(:post) do
    title('first post')
    body('winner')
  end

  factory(:comment) do
    text('first comment')
  end

end