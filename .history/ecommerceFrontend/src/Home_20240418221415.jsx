

// we kinda renamed "App" to "Home"
function Home() {

  return (
    <>
      <nav>
          <ul className="category_and_img">
              <div className="LogoHeader">
                <i class="bi bi-shop"></i> &nbsp; 
                <span>964Ecommerce</span>
              </div>
              <button>groceries</button>
              <button>clothing</button>
              <button>gaming</button>
          </ul>
          <hr style={{width:"1px"}} />
      </nav>
    </>
  )
}

export default Home;
