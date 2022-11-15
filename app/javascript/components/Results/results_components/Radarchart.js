import React from "react";
import {RadarChart, PolarGrid, PolarAngleAxis, PolarRadiusAxis, Radar, Legend} from 'recharts';
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
          <RadarChart outerRadius={100} width={600} height={250} data={props.block.data}>
              <PolarGrid />
              <PolarAngleAxis dataKey="subject" />
              <PolarRadiusAxis angle={30} domain={[0, 150]} />
              <Radar name="Mike" dataKey="A" stroke="#8884d8" fill="#8884d8" fillOpacity={0.6} />
              <Radar name="Lily" dataKey="B" stroke="#82ca9d" fill="#82ca9d" fillOpacity={0.6} />
              <Legend />
            </RadarChart>
        </div>
      </Row>
    </Container>
  </div>
);