import { useNavigate, useParams } from "react-router-dom";

export default function Account() {

    const navigate = useNavigate();
    let { acountNumber } = useParams();

    return (
        <main>
            <section class="infoSection">

                    <h3>Account: {acountNumber}</h3>
                    <button onClick={() => navigate('/')}>Sign Out</button>

            </section>
        </main>
    )
    
}