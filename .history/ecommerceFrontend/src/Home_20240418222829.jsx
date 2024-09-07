

// we kinda renamed "App" to "Home"
function Home() {

  return (
    <>
    <header>
      <div className="logo-container">
        <img src="../public/ecommerce.png"/>
        <p>
          Lorem ipsum dolor sit amet consectetur adipisicing elit. Aliquam, dignissimos. Rerum earum et, vitae porro hic, iusto, labore nostrum explicabo quam error velit quasi ipsum aperiam qui in doloremque quas minima eaque beatae quia nobis. Labore, quod in. Ex tempora, est asperiores, perspiciatis saepe soluta quia, atque eveniet dolorem explicabo officiis ipsam facilis? Dolorum cupiditate voluptate nobis, esse aut temporibus explicabo incidunt. Ex, corporis aspernatur! Quasi dolorem veniam nostrum eos. Ullam reiciendis itaque unde. Aliquam nobis quisquam doloribus ullam quod quas, atque laboriosam debitis veritatis culpa facilis accusamus. Iste placeat a facilis numquam non nostrum excepturi quod. Dignissimos, dicta asperiores.
        </p>
      </div>
    </header>
      <nav>
          <ul className="category_and_img border-right border-secondary">
              <div onClick={()=>{}} 
              className="HomeLogo">
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
