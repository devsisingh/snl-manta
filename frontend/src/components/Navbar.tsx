import { useState } from "react";
import { ConnectWallet } from "@thirdweb-dev/react";

const Navbar = () => {
  const [showMenu, setShowMenu] = useState(false);
 
  return (
      <div>
            <ConnectWallet theme={"dark"} modalSize={"wide"} />
      </div>
  );
};

export default Navbar;