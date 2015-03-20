require 'rails_helper'

describe 'the comments process' do

  it 'adds a new comment to a post' do
    go_home
    create_a_new_post
    add_a_new_comment
    expect(page).to have_content 'test comment'
    expect(page).to have_content 'Comment submitted!'
  end

  it 'edits comment' do
    go_home
    create_a_new_post
    add_a_new_comment
    click_on 'test comment'
    fill_in 'Text', with: 'edited comment'
    click_on 'Update Comment'
    expect(page).to have_content 'edited comment'
    expect(page).to have_content 'Comment updated!'
  end

  it 'deletes comment' do
    go_home
    create_a_new_post
    add_a_new_comment
    click_on 'test comment'
    click_on 'Delete Comment'
    :confirm
    expect(page).not_to have_content 'test comment'
    expect(page).to have_content 'Comment exterminated!'
  end


private

  def go_home
    visit '/'
  end

  def create_a_new_post
    click_on 'New Post'
    fill_in 'Title', with: 'test title'
    fill_in 'Body', with: 'test body'
    click_on 'Create Post'
  end

  def add_a_new_comment
    fill_in 'Text', with: 'test comment'
    click_on 'Add Comment'
  end

end

