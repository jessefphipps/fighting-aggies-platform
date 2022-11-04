import React from "react";

export default props => (
  <div className="bar">
    Hi I'm a Barchart component with the title:
    <h2>{props.block.title}</h2>
  </div>
);
