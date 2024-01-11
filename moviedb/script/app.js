const loadMovies = () => {
  let url = 'https://api.themoviedb.org/3/movie/550?api_key=91fc2d35b32e6f40891f2816dd6040bc';
  const promise = fetch(url);
  
  promise.then(response => {
    console.log(response);   
    return response.json();
  }).catch(error => {
    console.log('Error:', error);
  });
}

loadMovies();
