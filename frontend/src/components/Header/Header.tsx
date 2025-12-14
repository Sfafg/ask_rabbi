import React from "react";
import { Link } from "react-router-dom";
import { getRole, logout, getName } from "../../services/authService";

interface HeaderProps {
	role: string;
	setRole: (value: string) => void;
}

const Header: React.FC<HeaderProps> = ({ role, setRole }) => {
	return (
		<>
			<header>
				<nav>
					<Link to="/">
						<button>Home</button>
					</Link>

					{role === "n" && (
						<>
							<Link to="/Register">
								<button>Register</button>
							</Link>

							<Link to="/Login">
								<button>Login</button>
							</Link>
						</>
					)}
					{role !== "n" && (
						<>
							<button
								onClick={() => {
									logout();
									setRole(getRole());
								}}
							>
								Logout
							</button>
							Logged in as {getName()}
						</>
					)}
				</nav>
			</header>
		</>
	);
};
export default Header;
