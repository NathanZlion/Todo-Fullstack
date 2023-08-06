import "bootstrap/dist/css/bootstrap.css"
import { BrowserRouter, Routes, Route, Link } from "react-router-dom"

function DummyNavBar() {
  return (
    <nav className="navbar navbar-expand-lg navbar-light bg-light">
      <div className="container-fluid">
        <a className="navbar-brand">Navbar</a>
        {/* 4 navbar items: Home, VIP, Done */}
        <div className="collapse navbar-collapse" id="navbarNavAltMarkup">
          <div className="navbar-nav">
            <Link to="/todos">
              <a className="nav-link active">Home</a>
            </Link>
            <Link to="/todos/vip">
              <a className="nav-link">VIP</a>
            </Link>
            <Link to="/todos/done">
              <a className="nav-link">Done</a>
            </Link>
          </div>
        </div>
      </div>
    </nav>
  )
}

function App() {
  // return <RouterProvider router={router} />;
  return (
    <>
      <BrowserRouter>
        <Routes>
          <Route
            path="/"
            element={
              <>
                <DummyNavBar />
                <h1>Home</h1>
              </>
            }
          />
          <Route
            path="/login"
            element={
              <>
                <DummyNavBar />
                <h1>Login Screen</h1>
              </>
            }
          />
          <Route
            path="/register"
            element={
              <>
                <DummyNavBar />
                <h1>Sign up screen</h1>
              </>
            }
          />
          <Route
            path="/todos"
            element={
              <>
                <DummyNavBar />
                <h1>all todos</h1>
              </>
            }
          />
          <Route
            path="/todos/vip"
            element={
              <>
                <DummyNavBar />
                <h1>important todos</h1>
              </>
            }
          />
          <Route
            path="/todos/done"
            element={
              <>
                <DummyNavBar />
                <h1>done todos</h1>
              </>
            }
          />
          <Route
            path="/todos/:id"
            element={
              <>
                <DummyNavBar />
                <h1>To do with detail</h1>
              </>
            }
          />
          <Route
            path="*"
            element={
              <>
                <h1>Not Found</h1>
              </>
            }
          />
        </Routes>
      </BrowserRouter>
    </>
  )
}

export default App
