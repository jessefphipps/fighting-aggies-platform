import React from "react";
import {PieChart, Pie} from 'recharts';
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';

let renderLabel = function(entry) {
    return entry.name + ` (${entry.value})`;
}

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
         <PieChart width={730} height={300}>
          <Pie data={props.block.data} dataKey="value" nameKey="name" cx="50%" cy="50%" outerRadius={90} fill="#8884d8" label={renderLabel}/>
        </PieChart>
        </div>
      </Row>
    </Container>
  </div>
);
