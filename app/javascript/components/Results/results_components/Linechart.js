import React from "react";
import {LineChart, CartesianGrid, XAxis, YAxis, Tooltip, Legend, Line} from 'recharts';
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';

export default props => (
  <div className="bar" style={{
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
}}>
    <Container>
      <Row>
        <h3> {props.block.title} </h3>
      </Row>
      <Row>
        <div style={{
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
          }}>
          <LineChart width={600} height={200} data={props.block.data}
          margin={{ top: 5, right: 30, left: 20, bottom: 5 }}>
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="name" />
          <YAxis />
          <Tooltip />
          <Legend />
          <Line type="monotone" dataKey="pv" stroke="#8884d8" />
          <Line type="monotone" dataKey="uv" stroke="#82ca9d" />
        </LineChart>
        </div>
      </Row>
    </Container>
  </div>
);