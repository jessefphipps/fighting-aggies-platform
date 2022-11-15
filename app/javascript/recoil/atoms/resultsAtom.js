import {atom} from 'recoil';

export const resultsAtom = atom({
  key: 'results',
  default: {
    content: {}
  }
});