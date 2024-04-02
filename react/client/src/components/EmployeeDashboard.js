import React, { useState, useEffect } from 'react';
import axios from 'axios';

function EmployeeDashboard() {
  const [loading, setLoading] = useState(true);
  const [dashboardData, setDashboardData] = useState([]);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchDashboardData = async () => {
      try {
        setLoading(true);
        setError(null);

        const response = await axios.get('http://0.0.0.0:3000/api/employees/2');
        setDashboardData(response.data);
        setLoading(false);

      } catch (error) {
        console.error('Error fetching dashboard data:', error);
        setError('Failed to fetch dashboard data.');
        setLoading(false);
      }
    };

    fetchDashboardData();
  }, []);


  const { first_name, company_name, profile_picture_url, time_zone, role, manager, current_timesheet } = dashboardData;

  if (loading) return <div>Loading...</div>;
  if (!dashboardData) return <div>Error: The API server is not available at the moment. Please try again later.</div>;
  return (
    <div>
      <h1>Welcome, {first_name}!</h1>
      <p>{company_name}</p>
      {profile_picture_url && <img src={profile_picture_url} alt="Profile" />}
      <p>{time_zone}</p>
      <p>{role}</p>
      {manager && <p>Manager: {manager}</p>}
      <div className="timesheet-container">
        <h2>Current Timesheet</h2>
        {current_timesheet.length > 0 ? (
          <>
            <p>Pay Period: {current_timesheet[0].pay_period_start_date} - {current_timesheet[0].pay_period_end_date}</p>
            <table className="timesheet-table">
              <thead>
                <tr>
                  <th>Date</th>
                  <th>Hours Worked</th>
                  {/* Add more table headers if needed */}
                </tr>
              </thead>
              <tbody>
                {current_timesheet.map((entry, index) => (
                  <tr key={index}>
                    <td>{entry.started_at}</td>
                    <td>{entry.hours_worked}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </>
        ) : (
          <p>No timesheet entries for the current pay period.</p>
        )}

      </div>
    </div>
  );
}

export default EmployeeDashboard;
