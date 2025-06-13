import { LightningElement } from 'lwc';
export default class StopwatchUtilityBar extends LightningElement {
startTime;
  elapsedTime = 0;
  timer = false;
  interval;

  startStyle = '';
  stopStyle = 'display: none;';

  handleStart() {
    if (!this.timer) {
      this.startTime = performance.now() - this.elapsedTime;
      this.timer = true;
      this.startStyle = 'display: none;';
      this.stopStyle = 'display: inline-block;';
      this.runTimer();
    }
  }

  handleStop() {
    this.timer = false;
    this.elapsedTime = performance.now() - this.startTime;
    clearTimeout(this.interval);
    this.startStyle = 'display: inline-block;';
    this.stopStyle = 'display: none;';
  }

  handleReset() {
    this.timer = false;
    this.elapsedTime = 0;
    clearTimeout(this.interval);
    this.updateDisplay(0, 0, 0, 0);
    this.startStyle = 'display: inline-block;';
    this.stopStyle = 'display: none;';
  }

  runTimer() {
    if (this.timer) {
      const now = performance.now();
      this.elapsedTime = now - this.startTime;

      let totalMilliseconds = Math.floor(this.elapsedTime);
      let count = Math.floor((totalMilliseconds % 1000) / 10);
      let second = Math.floor((totalMilliseconds / 1000) % 60);
      let minute = Math.floor((totalMilliseconds / (1000 * 60)) % 60);
      let hour = Math.floor((totalMilliseconds / (1000 * 60 * 60)) % 24);

      this.updateDisplay(hour, minute, second, count);

      this.interval = setTimeout(() => this.runTimer(), 10);
    }
  }

  updateDisplay(hr, min, sec, count) {
    this.template.querySelector('#hr').textContent = hr < 10 ? '0' + hr : hr;
    this.template.querySelector('#min').textContent = min < 10 ? '0' + min : min;
    this.template.querySelector('#sec').textContent = sec < 10 ? '0' + sec : sec;
    this.template.querySelector('#count').textContent = count < 10 ? '0' + count : count;
  }
}