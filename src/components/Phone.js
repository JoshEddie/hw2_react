export default function Phone() {

    return (
        <>
        <section id="phoneCall" className="infoSection phone" style="display: none;">
        
            <h3>Phone:</h3>
            <h4 id="dial"></h4>

            <ul>
                <li onclick="dial('1')">1</li>
                <li onclick="dial('2')">2</li>
                <li onclick="dial('3')">3</li>
                <li onclick="dial('4')">4</li>
                <li onclick="dial('5')">5</li>
                <li onclick="dial('6')">6</li>
                <li onclick="dial('7')">7</li>
                <li onclick="dial('8')">8</li>
                <li onclick="dial('9')">9</li>
                <li onclick="dial('')">*</li>
                <li onclick="dial('0')">0</li>
                <li className="backspace" onclick="dial()">x</li>
            </ul>

            <button onclick="call()">Call</button>
        
        </section>
        </>
    );

}