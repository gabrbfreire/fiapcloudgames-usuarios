using System.Security.Claims;

namespace FiapCloudGames.Usuarios.Core.Interfaces;

public interface ITokenService
{
    string GenerateAccessToken(IEnumerable<Claim> claims);
}