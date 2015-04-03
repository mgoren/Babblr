require 'rails_helper'

describe 'the comments process' do

  it 'adds a new comment to a post' do
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post, user: user)
    login(user)
    go_home
    click_on post.title
    click_on "Add Comment"
    fill_in 'Comment:', with: 'test comment'
    click_on 'Create Comment'
    expect(page).to have_content 'test comment'
    expect(page).to have_content 'Comment submitted!'
  end

  it 'adds a new comment to a post with js', js: true do
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post, user: user)
    login(user)
    go_home
    click_on post.title
    click_on "Add Comment"
    fill_in 'Comment:', with: 'test comment'
    click_on 'Create Comment'
    expect(page).to have_content 'test comment'
  end

  it 'edits comment' do
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post, user: user)
    comment = FactoryGirl.create(:comment, user: user, post: post)
    login(user)
    go_home
    click_on post.title
    click_on comment.text
    fill_in 'Comment:', with: 'edited comment'
    click_on 'Update Comment'
    expect(page).to have_content 'edited comment'
    expect(page).to have_content 'Comment updated!'
  end

  it 'edits comment with js', js: true do
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post, user: user)
    comment = FactoryGirl.create(:comment, user: user, post: post)
    login(user)
    go_home
    click_on post.title
    click_on comment.text
    fill_in 'Comment:', with: 'edited comment'
    click_on 'Update Comment'
    expect(page).to have_content 'edited comment'
  end

  it 'deletes comment', js: true do
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post, user: user)
    comment = FactoryGirl.create(:comment, user: user, post: post)
    login(user)
    go_home
    click_on post.title
    click_on comment.text
    page.find("#delete_comment_#{comment.id}").trigger('click')
    expect(page).not_to have_content 'test comment'
    expect(page).to have_content 'Comment exterminated!'
  end

  it 'sends an sms on comment posting', js: true do
    user = FactoryGirl.create(:user, phone: ENV['TO_PHONE_NUMBER'])
    post = FactoryGirl.create(:post, user: user)
    login(user)
    go_home
    click_on post.title
    click_on "Add Comment"
    fill_in 'Comment:', with: 'test comment'
    click_on 'Create Comment'
    last_message_sent = Message.get_last_sms
    expect(last_message_sent['body']).to eq 'Your post (first post) has received the following response: test comment'
  end


end
