RSpec.shared_examples 'controlls access' do |model, status_code|
  it 'controlls access to index' do
    get :index
    expect(response).to have_http_status(status_code)
  end

  it 'controlls access to show' do
    subject = create model
    get :show, params: { id: subject.id }
    expect(response).to have_http_status(status_code)
  end

  it 'controlls access to edit' do
    subject = create model
    get :edit, params: { id: subject.id }
    expect(response).to have_http_status(status_code)
  end

  it 'controlls access to update' do
    subject = create model
    post :update, params: { id: subject.id, model => subject.attributes }
    expect(response).to have_http_status(status_code)
  end

  it 'controlls access to new' do
    get :new
    expect(response).to have_http_status(status_code)
  end

  it 'controlls access to create' do
    subject = attributes_for model
    post :create, params: { model => subject }
    expect(response).to have_http_status(status_code)
  end

  it 'controlls access to delete' do
    subject = create model
    delete :destroy, params: { id: subject.id }
    expect(response).to have_http_status(status_code)
  end
end

