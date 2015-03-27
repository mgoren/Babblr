require 'rails_helper'

describe 'the comments process' do

  it 'adds a new comment to a post' do
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post, user: user)
    login(user)
    go_home
    click_on post.title
    click_button "Add Comment"
    fill_in 'Comment:', with: 'test comment'
    click_on 'Submit Comment'
    expect(page).to have_content 'test comment'
    expect(page).to have_content 'Comment submitted!'
  end

  it 'edits comment' do
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post, user: user)
    comment = FactoryGirl.create(:comment, user: user, post: post)
    login(user)
    go_home
    click_on post.title
    click_on comment.text
    fill_in 'Text', with: 'edited comment'
    click_on 'Update Comment'
    expect(page).to have_content 'edited comment'
    expect(page).to have_content 'Comment updated!'
  end

  it 'deletes comment' do
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post, user: user)
    comment = FactoryGirl.create(:comment, user: user, post: post)
    login(user)
    go_home
    click_on post.title
    click_on comment.text
    click_on 'Delete Comment'
    :confirm
    expect(page).not_to have_content 'test comment'
    expect(page).to have_content 'Comment exterminated!'
  end

end

