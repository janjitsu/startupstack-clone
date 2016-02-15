#testing user experience

RSpec.feature 'User searching for offer',js: true do
  scenario 'sees tags for choosing' do
    visit root_path
    expect(page).to have_selector('li') 
  end
  scenario 'clicks on a tag and sees it is selected' do
    visit root_path
    page.first('li').click
    expect(page).to have_selector('li.selected')
  end
  scenario 'submits request and sees results' do
    visit root_path
    page.first('li').click
    page.find('.search-button').click
    expect(page).to have_selector('div.offer-item')
  end

end
