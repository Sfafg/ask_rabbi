import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import { useState } from "react";
import Home from "./pages/Home";
import Login from "./pages/Login";
import Register from "./pages/Register";
import { Header } from "./components/";

function App() {
	const [role, setRole] = useState("n");

	return (
		<Router>
			<Header role={role} setRole={setRole} />
			<Routes>
				<Route path="/" element={<Home />} />
				<Route path="/login" element={<Login setRole={setRole} />} />
				<Route path="/register" element={<Register setRole={setRole} />} />
			</Routes>
		</Router>
	);
}

export default App;
