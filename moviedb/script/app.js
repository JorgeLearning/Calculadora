const loadMovies = () => {
  let url = 'https://api.themoviedb.org/3/movie/popular?api_key=91fc2d35b32e6f40891f2816dd6040bc';
  const promise = fetch(url);
  
  promise.then(response => {
    console.log(response);   
    return response.json();
    console.log(response);   
  }).then(data => {
    let movies = '';
    data.results.forEach(movie => {
      movies += `<h1>${movie.title}</h1>`; 
    });
    document.getElementById('container').innerHTML = movies;
  }).catch(error => {
    console.log('Error:', error);
  });
}

loadMovies();
