import React, { Component } from "react";
import './Login.css';
import { Link}from "react-router-dom";
import 'bootstrap/dist/css/bootstrap.min.css';
import {Row, Col, Container} from 'react-bootstrap';
import logo from './photo1.gif'
import way1 from './way1.gif'

class Login extends Component {
    render() {
        return (
            <div className="not-found">
                <Col>
                <img 
                    className="forgif"
                    src={logo}
                />
                </Col>
                <Col>
                <Link className="btn" to="/upload"> <img className="arrow" src={way1}/> </Link>
                </Col>
                
            </div>
        );
    }
}


export default Login