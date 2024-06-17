/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import { Provider, TransactionRequest } from "@ethersproject/providers";
import type { Math, MathInterface } from "../Math";

const _abi = [
  {
    inputs: [],
    name: "MathOverflowedMulDiv",
    type: "error",
  },
];

const _bytecode =
  "0x60566037600b82828239805160001a607314602a57634e487b7160e01b600052600060045260246000fd5b30600052607381538281f3fe73000000000000000000000000000000000000000030146080604052600080fdfea26469706673582212204f13fdb1781f3305fc299657a0d60bca3167ebf43f36d9c04464d877f134e96264736f6c63430008140033";

type MathConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: MathConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class Math__factory extends ContractFactory {
  constructor(...args: MathConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
    this.contractName = "Math";
  }

  deploy(
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<Math> {
    return super.deploy(overrides || {}) as Promise<Math>;
  }
  getDeployTransaction(
    overrides?: Overrides & { from?: string | Promise<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(overrides || {});
  }
  attach(address: string): Math {
    return super.attach(address) as Math;
  }
  connect(signer: Signer): Math__factory {
    return super.connect(signer) as Math__factory;
  }
  static readonly contractName: "Math";
  public readonly contractName: "Math";
  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): MathInterface {
    return new utils.Interface(_abi) as MathInterface;
  }
  static connect(address: string, signerOrProvider: Signer | Provider): Math {
    return new Contract(address, _abi, signerOrProvider) as Math;
  }
}
