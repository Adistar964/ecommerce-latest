

// we kinda renamed "App" to "Home"
function Home() {

  return (
    <>
      <nav>
          <ul className="category_and_img">
              <div className="image display-inline-block">
                <i class="bi bi-shop"></i> &nbsp; 
                <p>964Ecommerce</p>
              </div>
              <button>groceries</button>
              <button>clothing</button>
              <button>gaming</button>
          </ul>
      </nav>
    </>
  )
}

export default Home;
