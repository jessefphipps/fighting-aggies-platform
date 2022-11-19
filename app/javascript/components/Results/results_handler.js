import React from "react";
import Barchart from "./results_components/Barchart";
import Linechart from "./results_components/Linechart";
import Piechart from "./results_components/Piechart";
import PlayerCard from "./results_components/PlayerCard";
import { Paper} from "@mui/material";
import { styled } from '@mui/material/styles';

function generateUID() {
    // I generate the UID from two parts here 
    // to ensure the random number provide enough bits.
    var firstPart = (Math.random() * 46656) | 0;
    var secondPart = (Math.random() * 46656) | 0;
    firstPart = ("000" + firstPart.toString(36)).slice(-3);
    secondPart = ("000" + secondPart.toString(36)).slice(-3);
    return firstPart + secondPart;
}

const FigureTile = styled(Paper)(({ theme }) => ({
    backgroundColor: theme.palette.mode === 'dark' ? '#1A2027' : '#fff',
    ...theme.typography.body2,
    padding: theme.spacing(1),
    margin: theme.spacing(1),
    textAlign: 'center',
    color: theme.palette.text.secondary,
    height: "100%"
  }));

const Components = {
  barchart: Barchart,
  linechart: Linechart,
  piechart: Piechart,
  card: PlayerCard,
};

export default (block) => {
  if (typeof Components[block.component] !== "undefined") {
    return (
      <FigureTile variant="elevation" elevation={2} key={generateUID()}>
        {React.createElement(Components[block.component], {
          key: generateUID(),
          block: block
        })}
    </FigureTile>
    );
  }
  return React.createElement(
    () => <div>The component {block.component} has not been created yet.</div>,
    { key: generateUID() }
  );
};