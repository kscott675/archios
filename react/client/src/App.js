import './App.css';
import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Header from './components/Header';
import HomePage from './components/HomePage';
import EmployeeDashboard from './components/EmployeeDashboard';
import HelloWorld from './components/HelloWorld';
import Footer from './components/Footer';

function App() {
  return (
    <Router>
      <div className="app">
        <Header />
        <main>
          {/* Use Routes to wrap Route components */}
          <Routes>
            {/* In React Router v6, you use the `element` prop to specify the component */}
            <Route exact path="/" element={<HomePage />} />
            <Route path="/employees/:employee_id" element={<EmployeeDashboard />} />
            <Route path="/HelloWorld" element={<HelloWorld />} />
          </Routes>
        </main>
        <Footer />
      </div>
    </Router>
  );
}
export default App;
