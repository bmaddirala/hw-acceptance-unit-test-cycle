describe Movie, type: :model do
    
    describe '.find_director' do
        it 'should find movies made by same director' do
            @movie = Movie.create!:title=>'The Post', :rating=>'PG-13', :director=>'Steven Spielberg', :release_date=>'22-Dec-2017' 
            @movie2 = Movie.create!:title=>'Lincoln', :rating=>'PG-13', :director=>'Steven Spielberg', :release_date=>'09-Nov-2012' 
            expect(Movie.find_director(@movie.director)) == [@movie,@movie2]
        end
        
        it 'should find movies made by different director' do
            @movie = Movie.create!:title=>'The Post', :rating=>'PG-13', :director=>'Steven Spielberg', :release_date=>'22-Dec-2017' 
            @movie2 = Movie.create!:title=>'Psycho', :rating=>'R', :director=>'Alfred Hitchcock', :release_date=>'08-Sep-1960' 
            expect(Movie.find_director(@movie.director)) !=  [@movie,@movie2]
        end
        
    end
    
    describe '.all_ratings' do 
        it 'finds all possible ratings' do 
            expect(Movie.all_ratings) == ['G', 'PG', 'PG-13', 'R']
    end
end

end