require 'rails_helper'

describe 'the posts process' do

  it 'creates a new post with valid input' do
    go_home
    create_a_new_post
    expect(page).to have_content 'test body'
  end

  it 'does not allow post creation if missing field' do
    go_home
    click_on 'New Post'
    fill_in 'Body', with: 'test body'
    click_on 'Create Post'
    expect(page).to have_content 'errors'
  end

  it 'shows newly created post on posts index' do
    go_home
    create_a_new_post
    go_home
    expect(page).to have_content 'test title'
  end

  it 'links to post view from posts index' do
    go_home
    create_a_new_post
    go_home
    click_on 'test title'
    expect(page).to have_content 'test body'
  end

  it 'allows editing of post' do 
    go_home
    create_a_new_post
    click_on 'test title'
    fill_in 'Body', with: 'edited body'
    click_on 'Update Post'
    expect(page).to have_content 'edited body'
    expect(page).to have_content 'successfully'
  end

  it 'deletes post' do
    go_home
    create_a_new_post
    post = Post.first
    find("#delete-post-#{post.id}").click
    :confirm
    expect(page).not_to have_content 'test title'
    expect(page).to have_content 'Post exterminated!'
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

end

