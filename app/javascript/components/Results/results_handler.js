import React from "react";
import Barchart from "./results_components/Barchart";
import { Paper} from "@mui/material";
import { styled } from '@mui/material/styles';

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
  barchart: Barchart
};

export default (block) => {
  if (typeof Components[block.component] !== "undefined") {
    return (
      <FigureTile variant="elevation" elevation={2} key={block._uid}>
        {React.createElement(Components[block.component], {
          key: block._uid,
          block: block
        })}
    </FigureTile>
    );
  }
  return React.createElement(
    () => <div>The component {block.component} has not been created yet.</div>,
    { key: block._uid }
  );
};