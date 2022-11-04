import React from "react";
import {BarChart, CartesianGrid, XAxis, YAxis, Tooltip, Legend, Bar} from 'recharts';
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
          <BarChart width="100%" height={200} data={props.block.data}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="name" />
            <YAxis />
            <Tooltip />
            <Legend />
            <Bar dataKey="1st" fill="#8884d8" />
            <Bar dataKey="2nd" fill="#82ca9d" />
          </BarChart>
        </div>
      </Row>
    </Container>
  </div>
);
