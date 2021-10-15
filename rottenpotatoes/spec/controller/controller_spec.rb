require "rails_helper"
require 'spec_helper'

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

describe MoviesController, type: :controller do
    
    
    describe 'index' do
        
        it 'should display the index' do
            get :index 
            expect(response).to render_template(:index)
        end
    end
    
    describe 'create' do 
        it 'creates a movie' do
            post :create, :movie => {:title=>'The Post', :rating=>'PG-13', :director=>'Steven Spielberg', :release_date=>'22-Dec-2017' }
            expect(assigns[:movie].title) == 'The Post'
        end
    end
    
    describe 'edit' do
        it 'edits a movie' do
            @movie =  Movie.create :title=>'The Post', :rating=>'PG-13', :director=>'Steven Spielberg', :release_date=>'22-Dec-2017' 
            get :edit, :id => @movie.id
            expect(response).to render_template(:edit)

    end
    end
    
    
    describe 'similar' do
        it 'has director' do 
            @movie = Movie.create!:title=>'The Post', :rating=>'PG-13', :director=>'Steven Spielberg', :release_date=>'22-Dec-2017' 
            @movie2 = Movie.create!:title=>'Lincoln', :rating=>'PG-13', :director=>'Steven Spielberg', :release_date=>'09-Nov-2012' 
            get :similar, :id=>@movie.id
            expect(assigns[:movies]) == [@movie, @movie2]
            expect(response).to render_template(:similar)
        end
        
        it 'has no director' do 
            @movie = Movie.create!:title=>'The Post', :rating=>'PG-13', :release_date=>'22-Dec-2017' 
            get :similar, {:id=>@movie.id}
            expect(response).to redirect_to movies_path
        end
    end
    
    
    describe 'new' do
        it 'new template' do 
            get :new
            expect(response).to render_template(:new)
        end 
    end
    
    describe 'show' do
        it 'shows movie page' do
        @movie = Movie.create!:title=>'The Post', :rating=>'PG-13', :release_date=>'22-Dec-2017' 
        get :show, {:id=>@movie.id}
        expect(response).to render_template(:show)
        expect(assigns[:movie]) == @movie
        end
    end
    

end



