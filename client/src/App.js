import "./App.css";
import { Routes, Route, Link } from "react-router-dom";
import Home from "./pages/Home";
import CreatePost from "./pages/CreatePost";
import Post from "./pages/Post";
import Login from "./pages/Login";
import Registration from "./pages/Registration";

function App() {
  return (
    <div className="App">
      <div className="navbar">
        <Link to="/">Home</Link>
        <Link to="/createpost">Create A Post</Link>
        <Link to="/login">Login</Link>
        <Link to="/registration">Registration</Link>
      </div>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/createpost" element={<CreatePost />} />
        <Route path="/post/:id" element={<Post />} />
        <Route path="/registration" element={<Registration />} />
        <Route path="/login" element={<Login />} />
      </Routes>
    </div>
  );
}

export default App;
