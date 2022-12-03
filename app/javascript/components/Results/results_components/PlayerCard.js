import * as React from 'react';
import Box from '@mui/material/Box';
import Card from '@mui/material/Card';
import CardActions from '@mui/material/CardActions';
import CardContent from '@mui/material/CardContent';
import Button from '@mui/material/Button';
import Typography from '@mui/material/Typography';
import chroma from 'chroma-js';

const f = chroma.scale(['#fc8c88', '#77f7a2']);

export default props => (
  
    <Card sx={{ minWidth: 275 }} style={{
          display: 'flex',
          alignItems: 'left',
          justifyContent: 'left',
          background: f((props.block.data.play_success_rate - 0.5)/(0.5))
      }}>
    <div className="bar" style={{
          display: 'flex',
          alignItems: 'left',
          justifyContent: 'left',
      }}>
      <CardContent style={{justifyContent: "left"}}>
        <Typography variant="h5" component="div" style={{justifyContent: "left"}}>
          {props.block.data.name}
        </Typography>
        <Typography sx={{ mb: 1.5 }} color="text.secondary" style={{justifyContent: "left"}}>
          {props.block.data.position}
        </Typography>
        <Typography variant="body2" style={{justifyContent: "left"}}>
          PLAY SUCCESS RATE: {props.block.data.play_success_rate}
        </Typography>
      </CardContent>
      <CardActions>
        <Button size="small">Learn More</Button>
      </CardActions>
      </div>
    </Card>
)