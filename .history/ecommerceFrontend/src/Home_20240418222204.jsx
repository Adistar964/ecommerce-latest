

// we kinda renamed "App" to "Home"
function Home() {

  return (
    <>
    <header>
      <img src="../public/ecommerce.png" alt="" />
    </header>
      <nav>
          <ul className="category_and_img border-right border-secondary">
              <div onClick={()=>{}} 
              className="LogoHeader">
                <i class="bi bi-house"></i> &nbsp; 
                <span>Home</span>
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
