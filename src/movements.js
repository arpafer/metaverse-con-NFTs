class KeyMovements {
    constructor() {
        this.movement = {};
        // to do it
        window.addEventListener("keydown", this.down.bind(this));
        window.addEventListener("keyup", this.up.bind(this));
    }

    isPressed(keyCode) {
        return this.movement[keyCode] ? this.movement[keyCode]: false;
    }

    down(e) {
        if (this.movement[e.keyCode]) return;
        this.movement[e.keyCode] = true;
        console.log("Keydown: ", e.key, "keyCode:", e.keyCode);

    }

    up(e) {
        this.movement[e.keyCode] = false;
        console.log("keyup: " + e.key, "keyCode: " + e.KeyCode);
    }
}

const Movements = new KeyMovements();
export default Movements;