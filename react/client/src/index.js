import React from 'react';
import ReactDOM from 'react-dom/client'; // Corrected import path
import './index.css';
import App from './App';

// Correctly access createRoot from react-dom/client
const container = document.getElementById('root');
const root = ReactDOM.createRoot(container);
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
