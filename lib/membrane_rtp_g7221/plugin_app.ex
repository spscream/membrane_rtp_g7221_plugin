defmodule Membrane.RTP.G7221.Plugin.App do
  @moduledoc false
  use Application
  alias Membrane.RTP.{G7221, PayloadFormat}

  @spec start(atom, list) ::
          {:ok, pid} | {:error, {:already_started, pid} | {:shutdown, term} | term}
  def start(_type, _args) do
    PayloadFormat.register(%PayloadFormat{
      encoding_name: :G7221,
      payloader: G7221.Payloader,
      depayloader: G7221.Depayloader,
      frame_detector: fn _payload -> true end
    })

    Supervisor.start_link([], strategy: :one_for_one, name: __MODULE__)
  end
end
