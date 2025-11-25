import React, { useState } from 'react';
import { useNavigate } from "react-router-dom";

async function login(username: string, password: string) {
    const response = await fetch(`${process.env.REACT_APP_API_URL}/users/login`, {
        method: "POST",
        headers: {"Content-Type":"application/json"},
        body: JSON.stringify({username,password})
    });


    const data = await response.json();

	if (!response.ok)
		throw {status:response.status, errors:data.errors || {"undefined":"Unknown error"}};

    return data.token;
}

function Login() {
	const [username, setUsername] = useState("");
	const [password, setPassword] = useState("");
    const [error, setError] = useState("");
    const navigate = useNavigate();

	async function handleSubmit(e: React.FormEvent) {
		e.preventDefault();
        setError("");

        if(username.length==0 || password.length==0){ setError("Empty login or password"); return}

		try {
			const jwt = await login(username, password);
            if(jwt){
                navigate("/");
                localStorage.setItem("token", jwt);
            } 
            else setError("No token received from the server");

		} catch(err:any){
              if (err.errors) {
                setError(Object.values(err.errors).join("\n"));
              } else {
                setError("Network error: Unable to reach the server");
                console.error(err);
              }
        } 
	}

	return (
		<div className="App">
			<header className="App-header">
				Login Screen
			</header>
			<form onSubmit={handleSubmit}>
				<label>Username</label>
				<input type="text" value={username} onChange={e=>setUsername(e.target.value)}></input>
				<label>password</label>
				<input type="password" value={password} onChange={e=>setPassword(e.target.value)}></input>
				<button type="submit">Login</button>
			</form>
            {error && <p>{error}</p>}
		</div>
	);
}

export default Login;
