require 'rails_helper'

describe 'the posts process' do

  it 'creates a new post with valid input' do
    user = FactoryGirl.create(:user)
    login(user)
    go_home
    click_on 'New Post'
    fill_in 'Title', with: 'test title'
    fill_in 'Body', with: 'test body'
    click_on 'Create Post'
    expect(page).to have_content 'test body'
  end

  it 'does not allow post creation if missing field' do
    user = FactoryGirl.create(:user)
    login(user)
    go_home
    click_on 'New Post'
    fill_in 'Body', with: 'test body'
    click_on 'Create Post'
    expect(page).to have_content 'errors'
  end

  it 'shows newly created post on posts index' do
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post, user: user)
    login(user)
    go_home
    expect(page).to have_content post.title
  end

  it 'links to post view from posts index' do
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post, user: user)
    login(user)
    go_home
    click_on post.title
    expect(page).to have_content post.body
  end

  it 'allows editing of post' do 
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post, user: user)
    login(user)
    go_home
    click_on post.title
    click_on post.title
    fill_in 'Body', with: 'edited body'
    click_on 'Update Post'
    expect(page).to have_content 'edited body'
    expect(page).to have_content 'successfully'
  end

  it 'deletes post' do
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post, user: user)
    login(user)
    go_home
    click_on post.title
    find("#delete-post-#{post.id}").click
    :confirm
    expect(page).not_to have_content 'test title'
    expect(page).to have_content 'Post exterminated!'
  end

end

