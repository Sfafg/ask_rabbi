import React, { useState } from 'react';
import { useNavigate } from "react-router-dom";

async function register(email: string, username: string, password: string, certificate: File | null) {
    const form = new FormData();
	form.append("email", email);
	form.append("username", username);
	form.append("password", password);
	if(certificate) form.append("certificate", certificate);

    const response = await fetch(`${process.env.REACT_APP_API_URL}/users/register`, {
        method: "POST",
        body: form
    });

    const data = await response.json();

	if (!response.ok)
		throw {status:response.status, errors:data.errors || {"undefined":"Unknown error"}};

    return data;
}

function Login() {
	const [email, setEmail] = useState("");
	const [username, setUsername] = useState("");
	const [password, setPassword] = useState("");
	const [certificate, setCertificate] = useState<File | null>(null);
	const [isRabbi, setIsRabbi] = useState(false);
    const [error, setError] = useState("");
    const navigate = useNavigate();

	async function handleSubmit(e: React.FormEvent) {
		e.preventDefault();
        setError("");

        if(username.length==0 || password.length==0){ setError("Empty login or password"); return}

		try {
			await register(email, username, password, certificate);
            navigate("/");

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
				Register Screen
			</header>
			<form onSubmit={handleSubmit}>
				<label>Email</label>
				<input type="email" value={email} onChange={e=>setEmail(e.target.value)}></input>
				<label>Username</label>
				<input type="text" value={username} onChange={e=>setUsername(e.target.value)}></input>
				<label>Password</label>
				<input type="password" value={password} onChange={e=>setPassword(e.target.value)}></input>
				<label>Are you a rabbi</label>
				<input type="checkbox" checked={isRabbi} onChange={e=>setIsRabbi(e.target.checked)}></input>
                {isRabbi && 
                    <>
                        <label>Are you a rabbi</label>
                        <input type="file" accept="image/png, image/jpeg" onChange={e=>{if(e.target.files && e.target.files.length>0)setCertificate(e.target.files[0])}}></input>
                    </>
                }
				<button type="submit">Register</button>
			</form>
            {error && <p>{error}</p>}
		</div>
	);
}

export default Login;
